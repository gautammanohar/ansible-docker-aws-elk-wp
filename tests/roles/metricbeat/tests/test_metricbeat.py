from testinfra.utils.ansible_runner import AnsibleRunner
testinfra_hosts = AnsibleRunner('.molecule/ansible_inventory').get_hosts('all')


def test_metricbeat_package(Package):
    metricbeat = Package('metricbeat')
    assert metricbeat.is_installed


def test_metricbeat_running_and_enabled(Service):
    metricbeat = Service("metricbeat")
    assert metricbeat.is_running
    assert metricbeat.is_enabled
