package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestSqlServerTestExample(t *testing.T){
  
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
  sqlserveroutput := terraform.Output(t, terraformOptions, "sql-server-name" )
  assert.Equal(t, "sfhjabfhjesabf", sqlserveroutput)

  // check connecting to the sql server

}
