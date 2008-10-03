require File.dirname(__FILE__) + '/../test_helper'
require 'fileutils'

class DTRPackageTaskTest < Test::Unit::TestCase
  def test_package
    testdata_dir = File.expand_path(File.dirname(__FILE__) + '/../../testdata')
    Dir.chdir(testdata_dir) do
      %x[rake dtr_package]
      assert File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/a_test_case2.rb")
      assert File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/lib/lib_test_case.rb")
      assert File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/is_required_by_a_test.rb")

      assert File.exists?(testdata_dir + "/dtr_pkg/codebase-dump.tar.bz2")

      %x[rake dtr_clobber_package]

      assert !File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/a_test_case2.rb")
      assert !File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/lib/lib_test_case.rb")
      assert !File.exists?(testdata_dir + "/dtr_pkg/codebase-dump/is_required_by_a_test.rb")

      assert !File.exists?(testdata_dir + "/dtr_pkg/codebase-dump.tar.bz2")
    end
  ensure
    FileUtils.rm_rf(testdata_dir + "/dtr_pkg") rescue nil
  end
end