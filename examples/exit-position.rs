use minus::error::MinusError;

fn main() -> Result<(), MinusError> {
    let pager = minus::Pager::new();

    // Add some sample content
    for i in 0..=100 {
        pager.push_str(format!("Line {}\n", i))?;
    }

    // Run the pager (user can scroll and then quit with 'q')
    minus::page_all(pager.clone())?;

    // After the pager exits, we can check what line the user was viewing
    if let Some(line) = pager.exit_position() {
        println!("User exited while viewing line {}", line);
    } else {
        println!("Exit position not available");
    }

    Ok(())
}
