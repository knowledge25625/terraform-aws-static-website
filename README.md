# Terraform AWS Static Website

A complete Infrastructure as Code (IaC) project using Terraform to provision a secure, publicly accessible static website hosted on an [Amazon S3](https://us-east-1.console.aws.amazon.com/s3/get-started?region=us-east-1) bucket.

## Project Structure

```text
terraform-aws-static-website/
├── index.html        # Sample HTML landing page
├── main.tf           # Core Terraform configurations (S3 bucket, public access, policy, website config, and object upload)
├── variables.tf      # Input variables (AWS region and bucket name)
├── output.tf         # Outputs the public website endpoint URL
└── .gitignore        # Excludes local Terraform state and cache files

```

## Prerequisites

Make sure you have the following installed on your local machine:

* [Terraform](https://www.terraform.io/) (>= 1.0.0)
* [AWS CLI](https://aws.amazon.com/cli/) (configured with your AWS credentials)
* VS Code (recommended)

## Deployment Steps

1. **Clone the repository:**
```bash
git clone https://github.com/knowledge25625/terraform-aws-static-website.git
cd terraform-aws-static-website

```


2. **Initialize Terraform:**
Download the required AWS provider plugins.
```bash
terraform init

```


3. **Preview the deployment:**
Review the infrastructure resources Terraform will create.
```bash
terraform plan

```


4. **Apply the configuration:**
Provision the AWS resources. Type `yes` when prompted.
```bash
terraform apply

```


5. **Access your website:**
Once the apply phase completes, Terraform will output your public `website_endpoint` URL. Paste that URL into your web browser to view your live site.

<img width="1110" height="747" alt="image" src="https://github.com/user-attachments/assets/1a5011a9-cbef-493a-bffd-ad047548c3a8" />

---

## Troubleshooting & Common Learning Curves

When building and deploying this project, you may run into a few common pitfalls. Here is how to resolve them:

### 1. GitHub File Size Limit Error (`GH001: Large files detected`)

* **The Cause:** By default, running `terraform init` downloads provider binaries (such as `terraform-provider-aws.exe`) inside the local `.terraform/` folder, which can be hundreds of megabytes. If you accidentally stage and commit these files, GitHub will reject your push because files exceed the 100 MB limit.
* **The Fix:** Ensure your `.gitignore` file includes `.terraform/` and `*.tfstate`. If you already committed them and need to clear your git history, use an orphan branch to create a clean commit timeline:
```bash
git checkout --orphan temp-branch
git add .
git commit -m "Initial clean commit"
git branch -D main
git branch -m main
git push -u origin main --force

```



### 2. Globally Unique S3 Bucket Names

* **The Cause:** S3 bucket names must be globally unique across all AWS accounts worldwide. If someone else already owns the name you chose in `variables.tf`, your `terraform apply` will fail with a `BucketAlreadyExists` or `BucketAlreadyOwnedByYou` error.
* **The Fix:** Open `variables.tf` and modify your `bucket_name` variable to something completely unique (e.g., adding your initials, random numbers, or your specific project suffix).

### 3. Public Access Block Settings

* **The Cause:** Modern AWS S3 security defaults block public access entirely. If visitors trying to view your website get a `403 Access Denied` error, your bucket policy or public access block settings may be misconfigured.
* **The Fix:** Ensure your `main.tf` explicitly includes the `aws_s3_bucket_public_access_block` resource configured with all options set to `false`, followed by a `depends_on` block linking it to your bucket policy.

---

