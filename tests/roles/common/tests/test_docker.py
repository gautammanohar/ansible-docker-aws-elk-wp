from testinfra.utils.ansible_runner import AnsibleRunner
testinfra_hosts = AnsibleRunner('.molecule/ansible_inventory').get_hosts('all')


def test_docker_package(Package):
    dockerengine = Package('docker-engine')
    assert dockerengine.is_installed
    assert dockerengine.version.startswith("17")
