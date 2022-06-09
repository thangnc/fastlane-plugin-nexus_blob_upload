describe Fastlane::Actions::RawUploadAction do
  describe '#run' do
    it "sets verbosity correctly" do
      expect(Fastlane::Actions::RawUploadAction.verbose(verbose: true)).to eq("--verbose")
      expect(Fastlane::Actions::RawUploadAction.verbose(verbose: false)).to eq("--silent")
    end

    it "sets upload url correctly for Nexus 3 with all required parameters" do
      tmp_path = Dir.mktmpdir
      file_path = "#{tmp_path}/file.ipa"
      FileUtils.touch(file_path)

      result = Fastlane::Actions::RawUploadAction.upload_url(
        endpoint: 'http://localhost:8081',
        repository: 'artifacts',
        raw_directory: 'com/fastlane',
        file_name: 'myproject',
        file: file_path.to_s
      )

      expect(result).to eq("http://localhost:8081/repository/artifacts/com/fastlane/myproject.ipa")
    end

    it "sets upload options correctly for Nexus 3 with all required parameters" do
      tmp_path = Dir.mktmpdir
      file_path = "#{tmp_path}/file.ipa"
      FileUtils.touch(file_path)

      result = Fastlane::Actions::RawUploadAction.upload_options(
        file: file_path.to_s,
        username: 'admin',
        password: 'admin123'
      )

      expect(result).to include("--upload-file #{file_path}")
      expect(result).to include('-u admin:admin123')
    end

    it "raises an error if file does not exist" do
      file_path = File.expand_path('/tmp/xfile.ipa')

      expect do
        result = Fastlane::FastFile.new.parse("lane :test do
                nexus_upload(file: '/tmp/xfile.ipa',
                            repository: 'artifacts',
                            raw_directory: 'com/fastlane',
                            file_name: 'test',
                            endpoint: 'http://localhost:8081',
                            username: 'admin',
                            password: 'admin123',
                            verbose: true,
                            ssl_verify: false)
              end").runner.execute(:test)
      end.to raise_exception("Couldn't find file at path '#{file_path}'")
    end

    it "runs the correct command for Nexus 3" do
      tmp_path = Dir.mktmpdir
      file_path = "#{tmp_path}/file.ipa"
      FileUtils.touch(file_path)
      result = Fastlane::FastFile.new.parse("lane :test do
              raw_upload(file: '#{file_path}',
                          repository: 'artifacts',
                          raw_directory: 'com/fastlane',
                          file_name: 'myproject',
                          endpoint: 'http://localhost:8081',
                          username: 'admin',
                          password: 'admin123',
                          verbose: true,
                          ssl_verify: false)
            end").runner.execute(:test)

      expect(result).to include("--upload-file #{file_path}")
      expect(result).to include('-u admin:admin123')
      expect(result).to include('--verbose')
      expect(result).to include('http://localhost:8081/repository/artifacts/com/fastlane/myproject.ipa')
      expect(result).to include('--insecure')
    end
  end
end
