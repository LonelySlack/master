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
