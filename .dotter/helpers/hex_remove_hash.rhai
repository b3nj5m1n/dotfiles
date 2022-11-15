let color = params[0];

if color.starts_with("#") {
    color.sub_string(1)
} else {
    color
}
