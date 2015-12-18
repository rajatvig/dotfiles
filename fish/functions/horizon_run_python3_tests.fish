function horizon_run_python3_tests
  source .tox/py34/bin/activate.fish
  python manage.py test --settings=horizon.test.settings horizon.test.tests
  python manage.py test --settings=openstack_dashboard.test.settings \
  openstack_dashboard.contrib.sahara.content.data_processing.data_sources.tests \
  openstack_dashboard.contrib.sahara.content.data_processing.job_binaries.tests \
  openstack_dashboard.contrib.sahara.content.data_processing.jobs.tests \
  openstack_dashboard.dashboards.admin.volumes.volumes.tests \
  openstack_dashboard.dashboards.identity.users \
  openstack_dashboard.dashboards.project.access_and_security.api_access.tests \
  openstack_dashboard.dashboards.project.images.images.tests.CreateImageFormTests \
  openstack_dashboard.dashboards.project.images.tests.ImagesAndSnapshotsUtilsTests \
  openstack_dashboard.dashboards.project.networks.tests \
  openstack_dashboard.dashboards.project.overview.tests \
  openstack_dashboard.dashboards.project.stacks.tests.TemplateFormTests \
  openstack_dashboard.dashboards.settings.password \
  openstack_dashboard.test.api_tests.base_tests.APIDictWrapperTests \
  openstack_dashboard.test.api_tests.base_tests.APIResourceWrapperTests \
  openstack_dashboard.test.api_tests.base_tests.ApiHelperTests \
  openstack_dashboard.test.api_tests.base_tests.ApiVersionTests \
  openstack_dashboard.test.api_tests.base_tests.QuotaSetTests \
  openstack_dashboard.test.api_tests.ceilometer_tests \
  openstack_dashboard.test.api_tests.cinder_rest_tests \
  openstack_dashboard.test.api_tests.cinder_tests \
  openstack_dashboard.test.api_tests.config_rest_tests \
  openstack_dashboard.test.api_tests.fwaas_tests \
  openstack_dashboard.test.api_tests.glance_rest_tests \
  openstack_dashboard.test.api_tests.glance_tests \
  openstack_dashboard.test.api_tests.heat_rest_tests \
  openstack_dashboard.test.api_tests.heat_tests \
  openstack_dashboard.test.api_tests.keystone_rest_tests \
  openstack_dashboard.test.api_tests.keystone_tests \
  openstack_dashboard.test.api_tests.lbaas_tests \
  openstack_dashboard.test.api_tests.network_rest_tests \
  openstack_dashboard.test.api_tests.neutron_rest_tests \
  openstack_dashboard.test.api_tests.neutron_rest_tests.NeutronPortsTestCase \
  openstack_dashboard.test.api_tests.nova_rest_tests \
  openstack_dashboard.test.api_tests.nova_tests \
  openstack_dashboard.test.api_tests.policy_rest_tests \
  openstack_dashboard.test.api_tests.rest_util_tests \
  openstack_dashboard.test.test_plugins.panel_group_tests.PanelGroupPluginTests \
  openstack_dashboard.test.test_plugins.panel_tests.PanelPluginTests \
  openstack_dashboard.test.tests.error_pages \
  openstack_dashboard.test.tests.policy \
  openstack_dashboard.test.tests.policy_backend \
  openstack_dashboard.test.tests.utils
end
