https://superuser.com/questions/1424478/can-i-hide-native-tabs-at-the-top-of-firefox

---

# **Hiding Native Tabs in Firefox with `userChrome.css`**

To hide the native tabs in Firefox, you'll need to create a `userChrome.css` file and apply the `visibility: collapse;` property.

---

## **Steps to Create `userChrome.css`**

1. **Access Your Profile Directory**  
   - Click on **Menu → Help → More Troubleshooting Information**  
   - OR navigate to `about:support` in the address bar.  

2. **Open the Profile Folder**  
   - Under the **Application Basics** section, find **Profile Folder**.  
   - Click the **Open Directory** button.

3. **Create or Edit `userChrome.css`**  
   - Inside the **Profile Directory**, create a new folder named `chrome`.  
   - Inside the `chrome` folder, create a new file named **`userChrome.css`**, or edit it if it already exists.

4. **Insert the Following CSS into `userChrome.css`**  
   ```css
   /* Hides the native tabs */
   #TabsToolbar {
     visibility: collapse;
   }
   ```

---

## **Optional Further Modifications**

You can add these additional rules to customize the interface:

### **Hide the Title Bar**
```css
#titlebar {
  visibility: collapse;
}
```

### **Hide the Sidebar Header**
```css
#sidebar-header {
  visibility: collapse !important;
}
```

---

## **Alternative Configuration by Xilin Sun**

This configuration hides the native tabs but also **leaves space for the window buttons**:

```css
/* Hides the native tabs */
#TabsToolbar {
  visibility: collapse;
}

/* Leaves space for the window buttons */
#nav-bar {
    margin-top: -8px;
    margin-right: 74px;
    margin-bottom: -4px;
}
```

---

## **Hover-Based Options for Showing Tabs on Hover**

If you'd like the tabs to remain hidden but appear when hovered over, try one of these options:

### **Option 1: Opacity-Based Hover Effect**  
```css
#TabsToolbar {
    opacity: 0.0;
}

#TabsToolbar:hover {
    opacity: 1.0;
}
```

### **Option 2: Visibility-Based Hover Effect**  
```css
#TabsToolbar {
    visibility: collapse;
}

#navigator-toolbox:hover #TabsToolbar {
    visibility: visible;
}
```

⚠️ *Note:* Using `visibility` may cause a flashy or jittery effect when hovering.

---

## **Final Step: Enable `userChrome.css` Support**

Before restarting Firefox, **you must enable custom stylesheets**:

1. Navigate to `about:config` in the address bar.
2. Search for `toolkit.legacyUserProfileCustomizations.stylesheets`.
3. Toggle the setting to **`true`**.

---

Now, close and relaunch Firefox to apply your changes! 🚀
