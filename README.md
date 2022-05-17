### K8s timestamp 

This terraform code is intended to bring up and test a restAPI application which is hosted on EKS via a managed node. 

#### Prerequisites

Ensure this is ran in a unix based terminal with access to the following packages.


 - Terraform => 1.1.0
 - Curl

#### Instructions 

Ensure your AWS account has the correction permissions to manage a EKS cluster. We can attach the following policy to assume the EKS role.

    {
        "Version": "2012-10-17",
        "Statement": [
     {
        "Effect": "Allow",
        "Principal": {
        "Service": "eks.amazonaws.com"
              },
        "Action": "sts:AssumeRole"
            }
         ] 
       }

Now export AWS ACCESS and SECRET keys within the terminal

`$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE`

`$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfKEY`

Navigate into the  `terraform` folder and run the `start.sh` script.

This will bring up the infrastructure which consits of a single ondemand EKS managed node running a deployment hosting the `azizn03/timestamp` app. It will also bringup a AWS native load balancer service. 

Once the terraform script has been completed it will output the following:

- `Cluster endpoint`
- `EKS status`
- `Load Balancer endpoint`

The first section of the test has been completed showing the EKS cluster if it has ran correctly it will show as active. The next section of the script goes  through the following loop 

    url=$(terraform output -raw timestamp_loadbalancer)
    
	until $(curl --output /dev/null --silent --fail "$url:8080/timestamp"); do
        printf '.'
        sleep 5
    done

This is the next and final stage of the testing phase which ill go through a loop and curl the endpoint until it retuns a response. Then the following section of the script is outputted showing the json message. It will also paste the URL which you can paste in the browser and test for yourself.

    echo
    curl $url:8080/timestamp
    echo
    echo "$url:8080/timestamp"
    echo

