
%w(install).each() do |recipe|
  include_recipe "#{cookbook_name}::#{recipe}"
end
