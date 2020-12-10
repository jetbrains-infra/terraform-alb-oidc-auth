# alb-oidc-auth
Terraform module to create ALB with GSuite auth.

### GSuite configuration
1. Go to GCP console -> [APIs/Credentials](https://console.cloud.google.com/apis/credentials)
2. Create credentials
3. Copy `client ID` and `client secret` to example/main.tf
4. Apply terraform code
5. Copy `auth_redirect_uri` from terrafrom outputs and paste it to the `Authorized redirect URIs` in GCP

### Links
1. [GSuite OpenID configuration parameters](https://accounts.google.com/.well-known/openid-configuration)