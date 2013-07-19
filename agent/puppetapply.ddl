metadata :name        => "Puppet apply command",
         :description => "Run Puppet code by Puppet apply command.",
         :author      => "Liu.cy",
         :license     => "Apache v.2",
         :version     => "1.0",
         :url         => "http://github.com/liucy1983/mcollective-puppetapply",
         :timeout     => 300

["apply"].each do |act|
  action act, :description => "#{act.capitalize} a code" do
    display :always

    input :code,
          :prompt      => "Code",
          :description => "The name of the code to #{act}",
          :type        => :string,
          :validation  => '^.+$',
          :optional    => false,
          :maxlength   => 300

    output :output,
           :description => "Command Output",
           :display_as  => "Output"

    output :error,
           :description => "Command Error",
           :display_as  => "Error"

    output :exitcode,
           :description => "Exit code of the puppet apply command",
           :display_as  => "Exit Code"

  end
end
