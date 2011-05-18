module MCollective
  module Agent
    class Deploy < RPC::Agent
      metadata :name        => "Deploy",
               :description => "Deployment agent",
               :author      => "Anonymous",
               :version     => "0.1",
               :license     => "private",
               :url         => "http://cn.com",
               :timeout     => 600

      action "war" do
        validate :source, String
        temp_file = '/tmp/companyNews.war'
        tomcat_webapps_dir = '/var/lib/tomcat6/webapps'
        run("rm #{temp_file}*")
        run("wget --output-document=#{temp_file} #{request[:source]}")
        run("service tomcat6 stop")
        run("rm -rf #{tomcat_webapps_dir}/*")
        run("cp #{temp_file} #{tomcat_webapps_dir}")
        run("service tomcat6 start")
      end
    end
  end
end
