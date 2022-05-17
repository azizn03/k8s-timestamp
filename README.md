### K8s timestamp 

This terraform code is intended to bring up and test a RestAPI endpoint which will return a json message on port 8080 from the /timestamp url which is hosted on EKS via a managed node. 

#### Prerequisites

Ensure this is ran on a unix based terminal with access to the following packages.

 - Terraform => 1.1.0
 - Curl

#### Instructions 

Ensure your AWS account has the correct permissions to manage a EKS cluster. We can attach the following policy to assume the EKS role.

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

Now export your AWS ACCESS and SECRET keys within the terminal using the following commands

`$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE`

`$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfKEY`

Navigate into the  `terraform` folder and run the `start.sh` script.

This will bring up the infrastructure which consits of a single on-demand EKS managed node running a deployment manifest with 3 replicas which will host the `azizn03/timestamp`app. The image is taken from my own Dockerhub public repo. To expose the RestAPI endpoint to the internet, a load balancer service is brought up, using the AWS native load balancer it will then provide a hostname accessible to the public to test the endpoint.. 

Once the terraform script has been completed it will output the following:

- `Cluster endpoint`
- `EKS status`
- `Load Balancer endpoint`

The first section of the test has been completed showing the EKS cluster status and if it has ran correctly it will show the EKS cluster as active. The next section of the script goes through the following loop: 

    url=$(terraform output -raw timestamp_loadbalancer)
    
	until $(curl --output /dev/null --silent --fail "$url:8080/timestamp"); do
        printf '.'
        sleep 5
    done

This is the next and final stage of the testing phase which involves going through a loop to curl the endpoint until it returns a response. Then the following section of the script is outputted showing the json message. It will also paste the URL which you can paste in the browser to test for yourself.

    echo
    curl $url:8080/timestamp
    echo
    echo "$url:8080/timestamp"
    echo

##### Misc

The App folder is there for anyone to look at the JS code to see how the RestAPI endpoint functions. The folder is not included in the terraform or bash script.
