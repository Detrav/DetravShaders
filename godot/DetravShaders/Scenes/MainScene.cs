using Godot;
using System;

[Tool]
public class MainScene : Control
{
    private Shader[] lastMaterials;
    private GridContainer grid;
    private int lastColumns;
    private float? updateTime;

    [Export]
    public Shader[] ShaderMaterials { get; set; } = new Shader[0];



    [Export]
    public PackedScene ShaderItem { get; set; }
    public override void _Ready()
    {
        grid = GetNode<GridContainer>("ScrollContainer/GridContainer");
        UpdateMaterials();
        lastColumns = grid.Columns;
    }

    public override void _Process(float delta)
    {
        base._Process(delta);

        if(lastColumns != grid.Columns)
        {
            lastMaterials = null;
            lastColumns = grid.Columns;
        }

        if (updateTime != null)
        {
            updateTime -= delta;
            if(updateTime < 0)
            {
                if(RectSize.x > RectSize.y - 100)
                {
                    grid.Columns = 3;
                }
                else
                {
                    grid.Columns = 1;
                }
                lastMaterials = null;
                updateTime = null;
            }
        }

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

            foreach (Node ch in grid.GetChildren())
            {
                ch.QueueFree();
            }

            float width = RectSize.x;

            GD.Print(width);

            if (grid.Columns >= 1)
            {
                width -= 10 * grid.Columns + 2 ;
                width /= grid.Columns;
                GD.Print(width);
            }

            GD.Print(width);


            foreach (var shader in ShaderMaterials)
            {
                var item = ShaderItem.Instance<ShaderItem>();
                item.RectMinSize = new Vector2(width, 0);
                item.RectSize = new Vector2(width, 0);
                item.ItemShader = shader;
                grid.AddChild(item);
            }
            lastMaterials = ShaderMaterials;
        }
    }

    public void _on_MainScene_resized()
    {
        updateTime = 0.15f;
    }
}
