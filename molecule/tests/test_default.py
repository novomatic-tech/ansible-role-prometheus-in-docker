import pytest
import os
from testinfra.utils.ansible_runner import AnsibleRunner

testinfra_hosts = AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.mark.parametrize("dirs", [
    "/etc/compose-files/env/prometheus/conf"
])
def test_directories(host, dirs):
    d = host.file(dirs)
    assert d.is_directory
    assert d.exists

@pytest.mark.parametrize("config", [
    "/etc/compose-files/env/prometheus/conf/prometheus.yml"
])
def test_template(host, config):
    file = host.file(config)
    assert file.is_file
    assert file.exists

