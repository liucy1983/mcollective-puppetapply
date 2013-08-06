class MCollective::Application::Puppetapply < MCollective::Application
  description "Use MCollective to run puppet code by puppet apply command"
  usage <<-EOF
  mco puppetapply <CODE>

  The CODE is a string

  EXAMPLES:
    mco puppet apply "file{'/tmp/test': }"
EOF

  def post_option_parser(configuration)
    if ARGV.size == 0
       raise "You must pass a command!"
    end

    if ARGV.size > 1
      raise "Please specify the command as one argument in single quotes."
    else
      configuration[:code] = ARGV.shift 
    end
  end

  def main
    $0 = "mco"
    code = configuration[:code]

    mc = rpcclient("puppetapply")
    mc.agent_filter(configuration[:agent])
    mc.discover :verbose => true

    results = []
    mc.apply(:code => code) do |node|
    	result = {:sender => node[:senderid],
    	  :statuscode => node[:body][:data][:exitcode],
    	  :statusmsg => node[:body][:data][:stdout] + node[:body][:data][:stderr]}
		
		  if options[:output_format] == "json"
        results.push result
		  else
        puts "Host: #{result[:sender]}"
        puts "Statuscode: #{result[:statuscode]}"
        puts "Output:\n#{result[:statusmsg]}" unless result[:statusmsg].empty?
		  end
    end
    puts results.to_json if options[:output_format] == 'json'

    mc.disconnect
  end

end
