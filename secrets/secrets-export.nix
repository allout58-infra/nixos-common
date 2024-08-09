{...}: {
  age.secrets = {
    "cloudflare-dns-challenge".file = ./cloudflare-dns-challenge.age;
    "jhollowell-email".file = ../secrets/my-email.age;
  };
}
