from testinfra.utils.ansible_runner import AnsibleRunner
testinfra_hosts = AnsibleRunner('.molecule/ansible_inventory').get_hosts('all')


def test_docker_package(Package):
    dockercompose = Package('docker-engine')
    assert dockercompose.is_installed
