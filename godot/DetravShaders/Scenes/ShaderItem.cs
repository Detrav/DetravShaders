using Godot;
using System;

[Tool]
public class ShaderItem : VBoxContainer
{
    private ColorRect colorRect;
    private Label label;
    [Export]
    public Shader ItemShader { get; set; }

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
}
