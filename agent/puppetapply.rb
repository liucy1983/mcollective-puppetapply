module MCollective
 module Agent
  class Puppetapply<RPC::Agent

    metadata    :name        => "Puppet Apply Command",
                :description => "Run puppet code by Puppet apply command",
                :author      => "Liu.cy",
                :license     => "Apache v.2",
                :version     => "1.0",
                :url         => "http://github.com/liucy1983/mcollective-puppetapply",
                :timeout     => 300

    action "apply" do
        validate :code, String

        out = []
        err = ""

        begin
          status = run("puppet apply -e '#{request[:code]}' --color=false", :stdout => out, :stderr => err, :chomp => true)
        rescue Exception => e
          reply.fail e.to_s
        end

        reply[:exitcode] = err.empty? ? status : 1
        reply[:stdout] = out.join(" ")
        reply[:stderr] = err
        reply.fail err if !(err.empty?) or status
    end

  end
 end
end
