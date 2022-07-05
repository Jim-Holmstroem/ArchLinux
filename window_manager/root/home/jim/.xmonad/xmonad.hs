{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid
import           System.Exit
import qualified Data.Map as Map

import           XMonad
import           XMonad.Actions.SpawnOn
import           XMonad.Config.Desktop
import           XMonad.Util.EZConfig
import           XMonad.Util.Paste
import qualified XMonad.StackSet as W

baseConfig = desktopConfig

-- second value from `xprop | grep WM_CLASS` (appName, className)
-- https://wiki.haskell.org/Xmonad/Frequently_asked_questions#I_need_to_find_the_class_title_or_some_other_X_property_of_my_program
programHook = composeAll
    [ className =? "Slack" --> doShift "9"
    , className =? "XClock" --> doFloat
    ]

-- pacman -S dmenu
dmenu = "exe=`dmenu_path | dmenu " ++ dmenu_settings ++ " ` && eval \"exec $exe\""
    where dmenu_settings = "-nb black -nf grey -sb magenta -sf white -fn \"-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*\""

-- (xdotool can do a lot of key inputs) => spawn "xdotool text 'jim.holmstroem@gmail.com'"
keyBindings conf@(XConfig {XMonad.modMask = modMask}) = Map.fromList $
    [ ((modMask              , xK_w     ), spawn "firefox")
    , ((modMask              , xK_a     ), spawn "firefox trello.com notion.com")
    , ((modMask              , xK_s     ), spawn "slack")
    , ((modMask              , xK_g     ), spawn $ XMonad.terminal conf)
    , ((modMask              , xK_f     ), spawn "xrandr --output eDP1 --primary --auto --output DP1 --off --output HDMI3 --off")
    , ((modMask .|. shiftMask, xK_f     ), spawn "xrandr --output eDP1 --off --output DP1 --primary --auto --left-of HDMI3 --output HDMI3 --auto")

    , ((modMask              , xK_p     ), spawn dmenu)

    , ((modMask .|. shiftMask, xK_c     ), kill)

    , ((modMask              , xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_n     ), refresh)

    , ((modMask              , xK_Tab   ), windows W.focusDown)
    , ((modMask              , xK_j     ), windows W.focusDown)
    , ((modMask              , xK_k     ), windows W.focusUp)
    , ((modMask              , xK_m     ), windows W.focusMaster)
 
    , ((modMask              , xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp)
 
    , ((modMask              , xK_h     ), sendMessage Shrink)
    , ((modMask              , xK_l     ), sendMessage Expand)
 
    , ((modMask              , xK_t     ), withFocused $ windows . W.sink)
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    , ((modMask              , xK_e     ), pasteString "jim.holmstroem@gmail.com")

    , ((modMask              , xK_z     ), spawn "slock") -- FIXME _NET_WM_PID missing? see https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Actions-SpawnOn.html
 
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [ ((modMask .|. m        , k        ), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) $ [xK_1 .. xK_9] -- TODO ++ [xK_0]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    ++
    [ ((modMask .|. m        , k        ), screenWorkspace screen >>= flip whenJust (windows . f))
        | (k, screen) <- zip [xK_x, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    ++
    [
      ((modMask .|. shiftMask, k        ), spawn $ "xrandr | grep connected | grep -v disconnected | awk '{print $1}' | sort | head -n " ++ show display ++ " | tail -n 1 | xargs -I{} xrandr --output {} --primary --auto")
        | (k, display) <- zip [xK_y, xK_u, xK_i, xK_o] [1..]
    ]

mouseBindings' (XConfig {XMonad.modMask = modMask}) = Map.fromList $
    [ ((modMask              , button1), (\w -> focus w >> mouseMoveWindow w
                                                        >> windows W.shiftMaster))
    , ((modMask              , button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask              , button3), (\w -> focus w >> mouseResizeWindow w
                                                        >> windows W.shiftMaster))
    ]

main = xmonad baseConfig
    { terminal = "st -f \"Hack:size=16\" tmux"
    , manageHook = programHook <+> manageHook baseConfig
    , modMask = mod4Mask
    , keys = keyBindings
    , mouseBindings = mouseBindings'
    }
