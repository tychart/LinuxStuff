Hmm, I just tried 2 different apps to hide the nav bar, but they say that they don't work for android 15.  
One thing that I could do is switch to the stock navigation gestures and would I be able to disable the side swiping of them in favor of the edge gestures app? 
I am totaly fine with the pill at the bottom, that is exactly what I like, I just want to not have the swiping from the left or right back buttons to interfear with edge gestures


Thanks for clarifying — and that's great context.

You're totally right that:

* **Nova Launcher** can only customize within the launcher itself (not inside other apps).
* On **Android 15**, even overlay-based nav-hiding apps mostly can't do anything due to **stricter system protections**.
* If you're **okay with the gesture pill**, but just want to **disable the side-swipe "Back" gesture** (so Edge Gestures can take over), **then you're in luck** — there's a viable path.

---

## ✅ Goal: Keep the bottom pill but disable the left/right swipe-back gestures

### 🔄 Current Limitation

Android doesn’t *officially* let you disable just the back gestures from the sides, but **Edge Gestures** can override them in most cases — **if you shrink the system gesture area**.

### ✅ Trick: **Shrink the system gesture back area to zero**

This disables the left and right swipe-back triggers without disabling gesture nav itself.

#### Run this ADB command:

```bash
adb shell settings put secure back_gesture_inset_scale_left 0.0
adb shell settings put secure back_gesture_inset_scale_right 0.0
```

> 💡 These were added in **Android 13** and still work in Android 15.

This will make the default back-swipe area *so small* that it’s effectively disabled. Your **Edge Gestures app** can now take over the screen edges.

> To reset it:

```bash
adb shell settings delete secure back_gesture_inset_scale_left
adb shell settings delete secure back_gesture_inset_scale_right
```

---

## ✅ Final Setup Summary

| Component           | What to use                    |
| ------------------- | ------------------------------ |
| Navigation mode     | Gesture navigation (with pill) |
| Back gesture swipes | Disabled with ADB above        |
| Edge gestures       | Full control of side gestures  |
| Launcher            | Nova for home screen tweaks    |

This combo gives you a clean pill at the bottom (no 3-button bar), **no accidental side-swipe backs**, and **complete control over edge behavior** via your app.

---

Let me know if you want help customizing Edge Gestures to do app-switching, quick toggles, or custom shortcuts with those edges — it pairs super well with this setup.
