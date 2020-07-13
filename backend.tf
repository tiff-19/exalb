terraform {
    backend "s3" {
        bucket  = "terraformstatetiff"
        key     = "terraform1/tfstate"
        region  = "ap-southeast-1"
    }
}