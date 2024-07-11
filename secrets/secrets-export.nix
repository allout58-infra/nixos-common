{...}: {
    age.secrets = {
        "cloudflare-dns-challenge" = ./cloudflare-dns-challenge.age;
        "jhollowell-email".file = ../secrets/my-email.age;
        
    };
}