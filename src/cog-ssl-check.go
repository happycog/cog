package main

import (
	"crypto/tls"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strings"
	"time"

	"github.com/fatih/color"
)

func main() {

	success := color.New(color.FgWhite, color.BgGreen, color.Bold).SprintFunc()
	info := color.New(color.FgBlack, color.BgYellow, color.Bold).SprintFunc()
	warn := color.New(color.FgWhite, color.BgRed, color.Bold).SprintFunc()

	// Don't follow redirects, and capture the original status code
	client := &http.Client{
		CheckRedirect: func(req *http.Request, via []*http.Request) error {
			return http.ErrUseLastResponse
		},
		Transport: &http.Transport{
			TLSClientConfig: &tls.Config{
				InsecureSkipVerify: true,
			},
		},
	}

	// Look for a URL as the argument, and use HC if none exists.
	RawURL := "https://happycog.com"

	if len(os.Args) > 1 {
		RawURL = os.Args[1]
	} else {
		fmt.Println("No URL passed, so using the default as an example.\n")
	}

	if !strings.HasPrefix(RawURL, "http") {
		RawURL = "https://" + RawURL
	}

	ParsedURL, err := url.Parse(RawURL)
	if err != nil {
		panic(err)
	}

	fmt.Printf("Getting certificate info for %s \n\n", info(ParsedURL.Host))

	resp, err := client.Get(ParsedURL.Scheme + "://" + ParsedURL.Host)
	if err != nil {
		panic(err)
	}

	if resp.StatusCode != 200 {
		fmt.Printf("%s: Status code is %d instead of 200.\n\n", info("Potential Issue"), resp.StatusCode)
	}

	CertInfo := GetCertInfo(resp)

	for _, item := range CertInfo {
		if item["IsError"] == true {
			fmt.Printf("%s:\n\t%s\n", warn(item["Name"]), item["Value"])
		} else {
			fmt.Printf("%s:\n\t%s\n", success(item["Name"]), item["Value"])
		}

	}
}

// GetCertInfo : Gets the correct certificate, parses it for specific data, and gets the info into a data structure for later use.
func GetCertInfo(r *http.Response) (CertInfo []map[string]interface{}) {

	tls := r.TLS

	if tls == nil {
		panic("Invalid SSL certificate.")
	}

	// We want the first certificate in the chain.
	// Each PeerCertificate is a Certificate type:
	// https://golang.org/pkg/crypto/x509/#Certificate
	cert := tls.PeerCertificates[0]

	IsExpired := time.Now().After(cert.NotAfter)
	IsntValidYet := time.Now().Before(cert.NotBefore)

	// Using a slice of maps instead of just a map, to guarantee order.
	// If the map has an "Error" key and it's set to true, the item will
	// display differently on output.
	CertInfo = []map[string]interface{}{
		{"Name": "Issued By", "Value": cert.Issuer},
		{"Name": "Validity Start", "Value": cert.NotBefore, "IsError": IsntValidYet},
		{"Name": "Expires", "Value": cert.NotAfter, "IsError": IsExpired},
		{"Name": "Common Name", "Value": cert.Subject.CommonName},
		{"Name": "SAN", "Value": strings.Join(cert.DNSNames, "\n\t")},
	}

	return

}
