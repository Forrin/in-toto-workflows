# in-toto-workflows

This repository contains a number of different workflows demonstrating how to build applications using [in-toto](https://in-toto.io/) and in-toto related tools. Please see the in-toto [Attestation Framework](https://github.com/in-toto/attestation) specification for more information.


# Github

The following workflows are designed to use [Github Actions](https://docs.github.com/en/actions).

The Attestation Framework can be used to define signed attestations of what occurred in the execution of a software supply chain. These attestations can be inspected and analyzed to assist with ensuring the integrity of a software supply chain. It's assumed that the workflow owners that generate in-toto attestations are trusted. Additional controls, such as code reviews should be implemented to further ensure integrity. In addition, it's possible for workflows to be owned by different "functionaries" ensuring a true form of separation of duties. Note that attestations can be manipulated and then signed by the creating workflow, so additional controls and design are required to ensure integrity.

Github supports the creation of in-toto Attestations using [Fulcio](https://docs.sigstore.dev/certificate_authority/overview/) for signing and [Rekor](https://docs.sigstore.dev/logging/overview/) for storage. Both tools are part of the [Sigstore](https://www.sigstore.dev/) project. A Fulcio certificate is a short lived certificate which will include the Github OIDC within the chain. Additional information within the certificate can be inspected, including the workflow information.

To inspect the certificate, download an example [attestation](https://github.com/Forrin/in-toto-workflows/attestations/), write the certificate to a new file (ensuring to include `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` formatting), and run the following:
```bash
openssl x509 -in cert.pem -text
```

Again, the assumption is that the workflow is semi trusted. For example, a build workflow could checkout a different git sha, however the attestation would show the sha for the executed commit and not the cloned commit within the resolved dependencies.

Through the use of OIDC, short lived certificates, and reusable workflows it's possible to have strong guarantees of the integrity of a software artifact.

## gh-complete Workflow

`gh-complete` is a workflow designed as the primary orchestrating workflow. This workflow leverages other workflows such as; build, scan, release, etc.

This workflow could be owned by an engineering team seeking to build and release their software.

## gh-build Reusable Workflow

`gh-build` is an example of a [Github Reusable Workflow](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for building a containerized application with [Docker](https://www.docker.com/).

This workflow is designed to build and push a container image to ghcr, and generate an in-toto [Provenance Attestation](https://github.com/in-toto/attestation/blob/main/spec/predicates/provenance.md) which is then attached to the callers repository.

This workflow could be owned by a build engineering team.
