package test

import (
	"fmt"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
	"time"
)

func TestSqlServerTestExample(t *testing.T) {

	// create an empty option struct
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
	})

	// init terraform
	terraform.InitAndApply(t, terraformOptions)

	// do the destroy as a defer
	defer terraform.Destroy(t, terraformOptions)

	// capture the output and check whether or not name of server is correct
	output := terraform.Output(t, terraformOptions, "group-name")
	assert.Equal(t, "rg-correct-name", output)
	sqlserveroutput := terraform.Output(t, terraformOptions, "sql-server-name")
	assert.Equal(t, "sfhjabfhjesabf", sqlserveroutput)

	// check connecting to the sql server
	// check connection to static web web
	//- Get the public address of the static web app
	url := terraform.Output(t, terraformOptions, "static-site-name")
	url_fmt := fmt.Sprintf("https://%s", url)
	http_helper.HttpGetWithRetry(t, url_fmt, nil, 200, "", 5, 5*time.Second)
}
