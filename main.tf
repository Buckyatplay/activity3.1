resource "local_file" "terraform_apply_yaml" {
  filename = "./github/workflows/terraform-apply.yaml"
  content  = <<-EOT
  name: Terraform Deployment

on:
  push:
    branches: [ "main" ]

env:            
  AWS_REGION: ap-southeast-1  

jobs:
  CICD:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v3
   
    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ${{ env.AWS_REGION }}

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
   
    - name: Terraform Init
      run: terraform init

    - name: Terraform Plan
      run: terraform plan
   
    - name: Terraform Apply
      run: terraform apply --auto-approve
