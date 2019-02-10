import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_gcloud_is_installed(host):
    gcloud = host.package("google-cloud-sdk")
    assert gcloud.is_installed
