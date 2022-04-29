using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

[Tool]
public class MainScene : Control
{
    private Resource[] lastMaterials;
    private GridContainer grid;
    private int lastColumns;
    private float? updateTime;
    private Resource[] materials;

    [Export]
    public int SelectedItem { get; set; }
    [Export]
    public PackedScene ShaderItem { get; set; }
    public override void _Ready()
    {
        List<Resource> materials = new List<Resource>();
        foreach (string shader in GetResources())
        {
            materials.Add(ResourceLoader.Load(shader));
        }

        foreach (var material in GetResources("material.tres", "res://Materials/"))
        {
            materials.Add(ResourceLoader.Load(material));
        }

        

        this.materials = materials.OrderBy(m => System.IO.Path.GetFileNameWithoutExtension(m?.ResourcePath ?? "None")).ToArray();

        grid = GetNode<GridContainer>("ScrollContainer/GridContainer");
        UpdateMaterials();
        lastColumns = grid.Columns;
    }

    private IEnumerable<string> GetResources(string fileExtentions = ".tres", string directoryName = "res://Shaders/", bool recursive = true)
    {
        if (!directoryName.EndsWith("/"))
            directoryName += "/";
        using (var dir = new Directory())
        {
            dir.Open(directoryName);
            dir.ListDirBegin();



            while (true)
            {
                var file = dir.GetNext();

                GD.Print(file);

                if (file.StartsWith("."))
                    continue;

                if (String.IsNullOrWhiteSpace(file))
                    break;

                file = directoryName + file;
                if (recursive && dir.DirExists(file))
                {
                    foreach (var subFile in GetResources(fileExtentions, file, recursive))
                    {
                        yield return subFile;
                    }
                }

                if (file.EndsWith(fileExtentions, StringComparison.OrdinalIgnoreCase))
                    yield return file;
            }
            dir.ListDirEnd();
        }
    }

    public override void _Process(float delta)
    {
        base._Process(delta);

        if (lastColumns != grid.Columns)
        {
            lastMaterials = null;
            lastColumns = grid.Columns;
        }

        if (updateTime != null)
        {
            updateTime -= delta;
            if (updateTime < 0)
            {
                if (RectSize.x > RectSize.y - 100)
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
        if (Engine.EditorHint && SelectedItem >= 0 && SelectedItem < grid.GetChildCount())
        {
            var item = grid.GetChild(SelectedItem) as Control;
            var scrollBar = GetNode<ScrollContainer>("ScrollContainer");
            scrollBar.ScrollVertical = (int)item.MarginTop;
        }

        if (materials != lastMaterials)
        {

            foreach (Node ch in grid.GetChildren())
            {
                ch.QueueFree();
            }

            float width = RectSize.x;

            if (grid.Columns >= 1)
            {
                width -= 10 * grid.Columns + 2;
                width /= grid.Columns;
            }


            foreach (var material in materials)
            {

                var item = ShaderItem.Instance<ShaderItem>();
                item.RectMinSize = new Vector2(width, 0);
                item.RectSize = new Vector2(width, 0);
                item.ItemShader = material;
                grid.AddChild(item);

            }
            lastMaterials = materials;
        }
    }

    public void _on_MainScene_resized()
    {
        updateTime = 0.15f;
    }
}
