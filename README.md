# Cupid [![Build Status](https://travis-ci.org/cyrusstoller/hbs-cupid.svg)](https://travis-ci.org/cyrusstoller/hbs-cupid)

## Getting your development environment setup

You will need to create a .env file in the `Cupid` directory. You should have the following variables defined.

```bash
SECRET_TOKEN=*SOME HEX STRING*
DEVISE_SECRET_KEY=*A DIFFERENT HEX STRING*

SMTP_DEV_EMAIL=a@example.com # Only necessary for development - where all emails will be delivered
SMTP_ADDRESS=smtp.mandrillapp.com
SMTP_DOMAIN=gmail.com
SMTP_USERNAME=cyrus.stoller@gmail.com
SMTP_PASSWORD=*any valid mandrill api key*
```

### API Keys

- Mandrill API: http://mandrill.com/