AddEventHandler('chatMessage',
  function(source, n, msg)
    msg = string.lower(msg)
    if msg == "/k" or msg == "/kneel" then
      CancelEvent()
      TriggerClientEvent('pa:kneelhu', source)
    elseif msg == "/r" or msg == "/radio" then
      CancelEvent()
      TriggerClientEvent('pa:radio', source)
    elseif msg == "/l" or msg == "/lie" or msg == "/liedown" then
      CancelEvent()
      TriggerClientEvent('pa:liedown', source)
    elseif msg == "/cpr" or msg == "/c" then
      CancelEvent()
      TriggerClientEvent('pa:cpr', source)
    end
  end
)
