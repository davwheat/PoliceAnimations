EventHandler('chatMessage', function(source, n, msg)
  msg = string.lower(msg)
  if msg == "/k" or msg == "/kneel" then
    CancelEvent()
    TriggerClientEvent('aa:kneelhu', source)
  end
end)