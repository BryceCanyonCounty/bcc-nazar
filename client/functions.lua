--Pulling Essentials
VORPcore = exports.vorp_core:GetCore()
BccUtils = exports['bcc-utils'].initiate()
FeatherMenu =  exports['feather-menu'].initiate()

NazarMainMenu = FeatherMenu:RegisterMenu('feather:nazar:mainMenu', {
    top = '5%',
    left = '5%',            
	['720width'] = '400px',
    ['1080width'] = '500px',
    ['2kwidth'] = '600px',
    ['4kwidth'] = '700px',
    style = {},
    contentslot = {
      style = {
        ['height'] = '350px',
        ['min-height'] = '250px'
      }
    },
    draggable = true
  }, {
    opened = function()
        DisplayRadar(false)
    end,
    closed = function()
        DisplayRadar(true)
    end,
})
