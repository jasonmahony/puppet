Facter.add("pgsql_version") do
  setcode do
    Facter::Util::Resolution.exec("cat /db/pgsql/data/PG_VERSION 2>/dev/null")
  end	
end
