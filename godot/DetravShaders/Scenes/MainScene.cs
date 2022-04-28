using Godot;
using System;

[Tool]
public class MainScene : Control
{
    private Shader[] lastMaterials;

    [Export]
    public Shader[] ShaderMaterials { get; set; } = new Shader[0];

    [Export]
    public PackedScene ShaderItem { get; set; }
    public override void _Ready()
    {
        UpdateMaterials();
    }

    public override void _Process(float delta)
    {
        base._Process(delta);


        UpdateMaterials();

    }

    private void UpdateMaterials()
    {
        if (Engine.EditorHint)
        {
            var scrollBar = GetNode<ScrollContainer>("ScrollContainer");
            scrollBar.ScrollVertical = 9999999;
        }

        if (ShaderMaterials != lastMaterials)
        {
            var grid = GetNode<GridContainer>("ScrollContainer/GridContainer");

            foreach (Node ch in grid.GetChildren())
            {
                ch.QueueFree();
            }

            foreach (var shader in ShaderMaterials)
            {
                var item = ShaderItem.Instance<ShaderItem>();
                item.ItemShader = shader;
                grid.AddChild(item);
            }
            lastMaterials = ShaderMaterials;
        }
    }
}
