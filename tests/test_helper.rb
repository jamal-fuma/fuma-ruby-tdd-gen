# encoding: UTF-8
require 'test/unit'

module TestMethods
    def assert_content_exists_on_disk(fname,content)
        dirname  = File.dirname(fname)
        assert File.directory?(dirname), "expected that #{dirname} dir would exist"
        assert File.exists?(fname), "expected that #{fname} file would exist"
        assert_equal content.chomp,File.read(fname).chomp, "expected that #{fname} file would have content"
    end
end
