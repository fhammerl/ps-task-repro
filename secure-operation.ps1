try {
    New-Object System.Security.Cryptography.X509Certificates.X509Certificate2("key.pfx", "")
    echo true >> success.txt
}
catch {
    $_ >> error.txt
}
    