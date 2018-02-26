AddEventHandler('chatMessage',
  function(source, n, msg)
    msg = string.lower(msg)
    if msg == "/k" or msg == "/kneel" then
      CancelEvent()
      TriggerClientEvent('pa:kneelhu', source)
    elseif msg == "/r" or msg == "/radio" then
      CancelEvent()
      TriggerClientEvent('pa:radio', source)
    end
  end
)
