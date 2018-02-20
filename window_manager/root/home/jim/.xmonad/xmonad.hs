{-# LANGUAGE OverloadedStrings #-}

import           Data.Monoid
import           System.Exit
import qualified Data.Map as Map

import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

baseConfig = desktopConfig

keyBindings conf@(XConfig {XMonad.modMask = modMask}) = Map.fromList $
    [ ((modMask              , xK_w     ), spawn "firefox")
    , ((modMask              , xK_g     ), spawn $ XMonad.terminal conf)
    , ((modMask              , xK_f     ), spawn "xrandr --output eDP1 --primary --auto --output DP1 --off --output HDMI3 --off")
    , ((modMask .|. shiftMask, xK_f     ), spawn "xrandr --output eDP1 --off --output DP1 --primary --auto --left-of HDMI3 --output HDMI3 --auto")

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
 
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [ ((modMask, language_key), spawn $ "setxkbmap -layout " ++ language) | (language_key, language) <- [( xK_o, "us"), ( xK_p, "sv")]
    ]
    ++
    [ ((modMask .|. m        , k        ), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
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
        | (k, display) <- zip [xK_y, xK_u, xK_i, xK_o, xK_p] [1..]
    ]

mouseBindings' (XConfig {XMonad.modMask = modMask}) = Map.fromList $
    [ ((modMask              , button1), (\w -> focus w >> mouseMoveWindow w
                                                        >> windows W.shiftMaster))
    , ((modMask              , button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask              , button3), (\w -> focus w >> mouseResizeWindow w
                                                        >> windows W.shiftMaster))
    ]

main = xmonad baseConfig
    { terminal = "st -f \"Hack:size=16\""
    , modMask = mod4Mask
    , keys = keyBindings
    , mouseBindings = mouseBindings'
    }
