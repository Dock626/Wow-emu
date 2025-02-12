shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float alpha = tex_color.a;

    // Glow effect
    vec4 glow_color = vec4(1.0, 1.0, 0.5, 0.5); // Yellowish glow
    vec4 final_color = mix(glow_color, tex_color, alpha);
    
    COLOR = final_color;
}