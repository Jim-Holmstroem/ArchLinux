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
    , ((modMask .|. shiftMask, xK_f     ), spawn "xrandr --output HDMI3 --primary --right-of eDP1 --output eDP1 --auto")

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
    [ ((modMask .|. m        , k        ), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    ++
    [ ((modMask .|. m        , k        ), screenWorkspace screen >>= flip whenJust (windows . f))
        | (k, screen) <- zip [xK_x, xK_z] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]


mouseBindings' (XConfig {XMonad.modMask = modMask}) = Map.fromList $
    [ ((modMask              , button1), (\w -> focus w >> mouseMoveWindow w
                                                        >> windows W.shiftMaster))
    , ((modMask              , button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modMask              , button3), (\w -> focus w >> mouseResizeWindow w
                                                        >> windows W.shiftMaster))
    ]


main = xmonad baseConfig
    { terminal = "st"
    , modMask = mod4Mask
    , keys = keyBindings
    , mouseBindings = mouseBindings'
    }
