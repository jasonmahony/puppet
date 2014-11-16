Facter.add("gateway") do
  setcode do
    %x{ip route | grep default | awk '{print $3}'}
  end
end
