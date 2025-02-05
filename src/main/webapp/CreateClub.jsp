<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Club</title>
    <link rel="icon" type="image/x-icon" href="https://cdn-b.heylink.me/media/users/og_image/a1adb54527104a50ac887d6a299ee511.webp">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }

        .wrapper {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .wrapper h1 {
            color: #00f2fe;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-field {
            margin-bottom: 15px;
        }

        .form-field label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .form-field input, 
        .form-field select, 
        .form-field textarea {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .form-field textarea {
            resize: none;
            height: 100px;
        }

        .form-field button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            color: white;
            background: #00f2fe;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .form-field button:hover {
            background: #4facfe;
        }

        .form-field button:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .wrapper {
                margin: 20px;
                padding: 20px;
            }

            .form-field button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <h1>Create Your Club</h1>
        <form action="CreateClub" method="post">
            <div class="form-field">
                <label for="clubName">Club Name</label>
                <input type="text" name="Club_Name" id="clubName" placeholder="Enter Club Name" required>
            </div>
            <div class="form-field">
                <label for="clubDesc">Club Description</label>
                <textarea name="Club_Desc" id="clubDesc" placeholder="Enter Club Description" required></textarea>
            </div>
            <div class="form-field">
                <label for="clubCategory">Club Category</label>
                <select name="Club_Category" id="clubCategory" required>
                    <option value="" disabled selected>Select Category</option>
                    <option value="Technology">Technology</option>
                    <option value="Arts">Arts</option>
                    <option value="Sports">Sports</option>
                    <option value="Business">Business</option>
                    <option value="Volunteer">Volunteer</option>
                </select>
            </div>
            <div class="form-field">
                <label for="clubEmail">Club Email</label>
                <input type="email" name="Club_Email" id="clubEmail" placeholder="Enter Club Email" required>
            </div>
            <div class="form-field">
                <button type="submit">Create Club</button>
            </div>
        </form>
    </div>
</body>
</html>
