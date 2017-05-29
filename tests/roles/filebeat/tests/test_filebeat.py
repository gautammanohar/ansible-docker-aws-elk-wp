from testinfra.utils.ansible_runner import AnsibleRunner
testinfra_hosts = AnsibleRunner('.molecule/ansible_inventory').get_hosts('all')


def test_filebeat_package(Package):
    filebeat = Package('filebeat')
    assert filebeat.is_installed


def test_filebeat_running_and_enabled(Service):
    filebeat = Service("filebeat")
    assert filebeat.is_running
    assert filebeat.is_enabled
