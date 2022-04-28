using Godot;
using System;

[Tool]
public class ShaderItem : VBoxContainer
{
    private ColorRect colorRect;
    private Label label;
    [Export]
    public Shader ItemShader { get; set; }

    private float lastWidth = 0;

    public override void _Ready()
    {
        colorRect = GetNode<ColorRect>("ColorRect");
        colorRect.Material = new ShaderMaterial()
        {
            Shader = ItemShader
        };
        label = GetNode<Label>("Label");
        label.Text = System.IO.Path.GetFileNameWithoutExtension(ItemShader?.ResourcePath ?? "None");
    }

    public override void _Process(float delta)
    {
        base._Process(delta);
        if (Mathf.Abs(colorRect.RectSize.x - lastWidth) > 0.01)
        {
            colorRect.RectMinSize = new Vector2(0, colorRect.RectSize.x);
            lastWidth = colorRect.RectSize.x;
        }
    }
}
