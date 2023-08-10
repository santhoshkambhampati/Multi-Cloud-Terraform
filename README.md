Overview:
    This project demonstrates how to use Terraform to deploy resources to multiple cloud providers, specifically AWS and GCP. The project is organized into separate directories for each cloud provider, with each directory containing its own Terraform configurations, modules, variables, and outputs.

Directory Structure:
        multi-cloud-terraform/
        |-- aws/
        |   |-- main.tf
        |   |-- variables.tf
        |   |-- outputs.tf
        |-- gcp/
        |   |-- main.tf
        |   |-- variables.tf
        |   |-- outputs.tf
        |-- main.tf
        |-- variables.tf
        |-- outputs.tf

Functionality:

    AWS Configuration (aws directory):
        The aws directory contains the Terraform configuration for provisioning resources in AWS.

            1. main.tf: Defines an AWS EC2 instance using the specified AMI, instance type, and region.
            2. variables.tf: Defines input variables specific to AWS, like the region, instance AMI, and instance type.
            3. outputs.tf: Declares an output variable that displays the public IP address of the AWS EC2 instance.

    GCP Configuration (gcp directory):

        The gcp directory contains the Terraform configuration for provisioning resources in Google Cloud Platform.

            1. main.tf: Defines a GCP Compute Engine instance using the specified machine type, region, and image.
            2. variables.tf: Defines input variables specific to GCP, such as the project ID, region, machine type, and instance image.
            3. outputs.tf: Declares an output variable that displays the external IP address of the GCP Compute Engine instance.
    
    Root Configuration (main.tf, variables.tf, outputs.tf):
        The root directory contains the main configuration that ties everything together.

            1. main.tf: References the AWS and GCP modules, passing the required input variables.
            2. variables.tf: Defines shared input variables that are used in both AWS and GCP configurations.
            3. outputs.tf: Declares output variables that provide information about the created instances in both AWS and GCP.

How It Works:

    Start by navigating to the aws directory and run terraform init and terraform apply to provision the AWS resources (EC2 instance). This directory uses input variables like aws_region, instance_ami, and instance_type.

    Next, navigate to the gcp directory and run terraform init and terraform apply to provision the GCP resources (Compute Engine instance). This directory uses input variables like gcp_project, gcp_region, instance_machine_type, and instance_image.

    Finally, in the root directory, run terraform init and terraform apply to bring together both AWS and GCP resources. This directory uses input variables like aws_region, instance_ami, instance_type, gcp_project, gcp_region, instance_machine_type, and instance_image. The outputs of both AWS and GCP resources are displayed as well.

Summary:

This multi-cloud Terraform project demonstrates how to deploy resources to both AWS and GCP using a modular and organized approach. By separating configurations into provider-specific directories and utilizing shared variables, the project showcases the flexibility and power of Terraform for multi-cloud deployments. The root directory ties everything together and displays output information from both cloud providers' resources.