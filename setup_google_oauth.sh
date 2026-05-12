#!/bin/bash
# DeenApp - Automated Google OAuth Setup
# Run: bash setup_google_oauth.sh

GCLOUD="/opt/homebrew/share/google-cloud-sdk/bin/gcloud"
PROJECT_ID="${PROJECT_ID:-deenapp-$(date +%s | tail -c 6)}"
SUPABASE_PROJECT_REF="${SUPABASE_PROJECT_REF:-your-project-ref}"
SUPABASE_CALLBACK="https://${SUPABASE_PROJECT_REF}.supabase.co/auth/v1/callback"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  DeenApp - Google OAuth Auto Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 1: Login
echo "▶ Step 1: Login ke Google Cloud..."
$GCLOUD auth login --no-launch-browser 2>&1

# Step 2: Create project
echo ""
echo "▶ Step 2: Membuat project '$PROJECT_ID'..."
$GCLOUD projects create $PROJECT_ID --name="DeenApp"
$GCLOUD config set project $PROJECT_ID

# Step 3: Enable APIs
echo ""
echo "▶ Step 3: Mengaktifkan Google APIs..."
$GCLOUD services enable cloudresourcemanager.googleapis.com
$GCLOUD services enable iamcredentials.googleapis.com

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ⚠️  LANGKAH MANUAL (tidak bisa diotomasi)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "OAuth consent screen & credentials TIDAK BISA dibuat"
echo "via CLI tanpa billing account. Buka link ini:"
echo ""
echo "1. Buat OAuth consent screen:"
echo "   https://console.cloud.google.com/apis/credentials/consent?project=$PROJECT_ID"
echo ""
echo "2. Buat OAuth 2.0 Credentials:"
echo "   https://console.cloud.google.com/apis/credentials/oauthclient?project=$PROJECT_ID"
echo ""
echo "   - Type: Web application"
echo "   - Authorized redirect URI:"
echo "     $SUPABASE_CALLBACK"
echo ""
echo "3. Copy Client ID & Secret ke Supabase:"
echo "   https://supabase.com/dashboard/project/${SUPABASE_PROJECT_REF}/auth/providers"
echo ""
