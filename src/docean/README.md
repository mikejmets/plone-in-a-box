## Create Plone-in-a-box image on Digital Ocean
> Create an account and/or sign in to [Digital Ocean](https://digitalocean.com)
>
> In the control panel select `API`, select `Generate New Token` button, copy the token and keep it safe
>
> In the control panel select `Settings`, one the `Security` tab, select `Add SSH Key` and upload your public key. The name you provide here will be used later.
>
> On you local machine, install terraform - follow instructions on [HashiCorp](https://learn.hashicorp.com/tutorials/terraform/install-cli)
```
git clone from https://github.com/collective/plone-in-a-box.git
cd src/docean
```
> Ensure the ssh key name in line 19 of `provider.tf` matches the name you used when adding your SSH key above

```
terraform init
terraform apply --var 'pub_key=path-to-rsa_id_rsa.pub' --var="pvt_key=path-to-rsa_id_rsa" --var 'do_token=API_TOKEN'
```
> Answer `yes` to the question `Do you want to perform these actions?` to create a droplet
>
>In the DigitalOcean account, check that the droplet was created
