using System;
using System.Collections.Generic;
using CocosSharp;
using Microsoft.Xna.Framework;

namespace CocosSharpGame1
{
    public class IntroLayer : CCLayerColor
    {

        // Define a label variable
        CCLabel label;

        public IntroLayer() : base(CCColor4B.Blue)
        {

            // create and initialize a Label
            label = new CCLabel("Hello CocosSharp", "fonts/MarkerFelt", 22, CCLabelFormat.SpriteFont);

            // add the label as a child to this Layer
            AddChild(label);

        }

        protected override void AddedToScene()
        {
            base.AddedToScene();

            // Use the bounds to layout the positioning of our drawable assets
            var bounds = VisibleBoundsWorldspace;

            // position the label on the center of the screen
            label.Position = bounds.Center;

            // Register for touch events
            var mouseListener = new CCEventListenerMouse();
            mouseListener.OnMouseUp = OnTouchesEnded;
            AddEventListener(mouseListener, this);

            var pop = new CCSprite("images/download.png", new CCRect(0, 0, 500, 500));
            pop.Position = new CCPoint(500, 500);
            AddChild(pop);

        }

        void OnTouchesEnded(CCEvent touchEvent)
        {
            label = new CCLabel("POP", "fonts/MarkerFelt", 22, CCLabelFormat.SpriteFont);
            label.Position = new CCPoint(100, 100);
            AddChild(label);
        }
    }
}

