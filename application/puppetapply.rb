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

    puts "\n"

    mc.apply(:code => code) do |node|
    	result = Hash.new()
		result[:sender] = node[:senderid]
    	result[:exitcode] = node[:body][:data][:exitcode]
    	result[:output] = node[:body][:data][:stdout]
    	result[:error] = node[:body][:data][:stderr]
		
		if options[:output_format] == "json"
			puts result.to_json
		else
			puts "Host: #{result[:sender]}"
			puts "Host: #{result[:exitcode]}"
			puts "Output:\n#{result[:output]}" unless result[:output].empty?
			puts result[:error] unless result[:error]
		end
        puts "\n"
    end

    mc.disconnect
  end

end
